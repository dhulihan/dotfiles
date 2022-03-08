export DOCKER_BUILDKIT=0

# disable fancy useless UX
export BUILDKIT_PROGRESS=plain

if (( $+commands[docker-machine] ))
then
  #eval "$(docker-machine env default)"
fi
