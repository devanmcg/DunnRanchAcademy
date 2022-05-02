pacman::p_load(foreach, doSNOW)

imagery_dir = 'S:/DevanMcG/GIS/SpatialData/NorthDakota/imagery/AdamsCounty'

tars <- list.files(imagery_dir, '.tar.gz')

{
  begin = Sys.time()
  cores = parallel::detectCores()
  cl <- makeCluster(cores) 
  registerDoSNOW(cl)

  foreach(i=1:length(tars) ) %dopar% {
    untar(paste0(imagery_dir, '/', tars[i]), 
          exdir = imagery_dir)
  }
  stopCluster(cl)
  Sys.time() - begin
}

# Bucyrus wildfire Oct 2012
{
  begin = Sys.time()
  imagery_dir = 'S:/DevanMcG/GIS/SpatialData/NorthDakota/imagery/AdamsCounty/bucyrus'
  tars <- list.files(imagery_dir, '.tar.gz')
  cores = parallel::detectCores()
  cl <- makeCluster(ifelse(cores > length(tars), length(tars), cores)) 
  registerDoSNOW(cl)
  
  foreach(i=1:length(tars) ) %dopar% {
    untar(paste0(imagery_dir, '/', tars[i]), 
          exdir = imagery_dir)
  }
  stopCluster(cl)
  Sys.time() - begin
}

# Hettinger wildfire 2021
{
  begin = Sys.time()
  imagery_dir = 'S:/DevanMcG/GIS/SpatialData/NorthDakota/imagery/AdamsCounty/hettinger'
  tars <- list.files(imagery_dir, '.tar.gz')
  cores = parallel::detectCores()
  cl <- makeCluster(ifelse(cores > length(tars), length(tars), cores)) 
  registerDoSNOW(cl)
  
  foreach(i=1:length(tars) ) %dopar% {
    untar(paste0(imagery_dir, '/', tars[i]), 
          exdir = imagery_dir)
  }
  stopCluster(cl)
  Sys.time() - begin
}

# NDSU PBG pastures
{
  begin = Sys.time()
  imagery_dir = 'S:/DevanMcG/GIS/SpatialData/NorthDakota/imagery/PBG_studies'
  tars <- list.files(imagery_dir, '.tar.gz')
  cores = parallel::detectCores()
  cl <- makeCluster(ifelse(cores > length(tars), length(tars), cores)) 
  registerDoSNOW(cl)
  
  foreach(i=1:length(tars) ) %dopar% {
    untar(paste0(imagery_dir, '/', tars[i]), 
          exdir = imagery_dir)
  }
  stopCluster(cl)
  Sys.time() - begin
}

