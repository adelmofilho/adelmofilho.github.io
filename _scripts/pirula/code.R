library(tuber)
library(stringr)
library(dplyr)
library(RJSONIO)
library(magrittr)

isNull <- function(x){
  
  if (is.null(x)) {
    
    y <- NA
    
  } else {
    
    y <- x
  }
  
  return(y)
  
}

duration <- function(time){
  
  if (grepl("H", time, fixed=TRUE)) {
    
    hour <- as.numeric(sub(".*PT *(.*?) *H.*", "\\1", time))
    
    minute <- as.numeric(sub(".*H *(.*?) *M.*", "\\1", time))
    
    second <- as.numeric(sub(".*M *(.*?) *S.*", "\\1", time))
    
    total <- second + 60*minute + 3600*hour
    
  } else {
    
    minute <- as.numeric(sub(".*PT *(.*?) *M.*", "\\1", time))
   
    second <- as.numeric(sub(".*M *(.*?) *S.*", "\\1", time))
    
    total <- second + 60*minute
    
  } 
  
  return(total)
  
}

key     <- "AIzaSyBQyA88Cb1SNzHVfrQq7OL5rb9cujL9Lh4"
channel <- "UCdGpd0gNn38UKwoncZd9rmA"

url <- paste0("https://www.googleapis.com/youtube/v3/search?",
              "channelId=", channel,
              "&key=",key,
              "&part=snippet",
              "&maxResults=1",
              "&type=video")

x <- fromJSON(url, simplify = FALSE)

videos_n <- x$pageInfo$totalResults

# Primeiro Vídeo Request ----

video_id    <- x$items[[1]]$id$videoId
video_time  <- substr(x$items[[1]]$snippet$publishedAt, start = 1, stop = 10)
video_title <- x$items[[1]]$snippet$title

url_video <- paste0("https://www.googleapis.com/youtube/v3/videos?",
                    "id=", video_id,
                    "&key=",key,
                    "&part=snippet,contentDetails,statistics,status")

y <- fromJSON(url_video, simplify = FALSE)

video_duration_raw <- y$items[[1]]$contentDetails$duration

viewCount <-  isNull(y$items[[1]]$statistics$viewCount)
likeCount <- isNull(y$items[[1]]$statistics$likeCount)
dislikeCount <- isNull(y$items[[1]]$statistics$dislikeCount)
favoriteCount <- isNull(y$items[[1]]$statistics$favoriteCount)
commentCount <- isNull(y$items[[1]]$statistics$commentCount)

# video_duration <- duration(video_duration_raw)

# Geração da tabela de registro dos resultados ----

dados <- data.frame(title = video_title, 
                    time = video_time, 
                    duration = video_duration_raw, 
                    viewCount = viewCount,
                    likeCount = likeCount,
                    dislikeCount = dislikeCount,
                    favoriteCount = favoriteCount,
                    commentCount = commentCount,
                    
                    stringsAsFactors = FALSE)

# Acesso aos demais vídeos ----

for (i in 1:(videos_n-2)) {
  
  url <- paste0("https://www.googleapis.com/youtube/v3/search?",
                "channelId=", channel,
                "&key=",key,
                "&part=snippet",
                "&maxResults=1",
                "&pageToken=",x$nextPageToken,
                "&type=video")
  
  x <- fromJSON(url, simplify = FALSE)
  
  video_id    <- x$items[[1]]$id$videoId
  video_time  <- substr(x$items[[1]]$snippet$publishedAt, start = 1, stop = 10)
  video_title <- x$items[[1]]$snippet$title
  
  url_video <- paste0("https://www.googleapis.com/youtube/v3/videos?",
                      "id=", video_id,
                      "&key=",key,
                      "&part=snippet,contentDetails,statistics,status")
  
  y <- fromJSON(url_video, simplify = FALSE)
  
  video_duration_raw <- y$items[[1]]$contentDetails$duration
  
  viewCount <-  isNull(y$items[[1]]$statistics$viewCount)
  likeCount <- isNull(y$items[[1]]$statistics$likeCount)
  dislikeCount <- isNull(y$items[[1]]$statistics$dislikeCount)
  favoriteCount <- isNull(y$items[[1]]$statistics$favoriteCount)
  commentCount <- isNull(y$items[[1]]$statistics$commentCount)
  
  # video_duration <- duration(video_duration_raw)
  
  input <- data.frame(title = video_title, 
                      time = video_time, 
                      duration = video_duration_raw, 
                      viewCount = viewCount,
                      likeCount = likeCount,
                      dislikeCount = dislikeCount,
                      favoriteCount = favoriteCount,
                      commentCount = commentCount,
                      
                      stringsAsFactors = FALSE)
  
  dados %<>% bind_rows(input)
  
  print(paste0(round(i/videos_n,2)*100,"%"))
  
}

dados %<>% 
  as_tibble() %>% 
  distinct()