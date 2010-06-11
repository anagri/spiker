# should only be used when request is available
def full_url(path)
  request.protocol + request.host_with_port + path
end
