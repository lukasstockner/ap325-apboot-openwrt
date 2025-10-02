FROM debian:trixie

RUN apt update && apt install -y --no-install-recommends make gcc gcc-arm-none-eabi python3 libc6-dev git
COPY . /src

WORKDIR /src
RUN LABELID=$(git rev-parse --short HEAD) make -f Makefile.releng octomore

CMD ["/bin/bash", "-c", "cat < /src/u-boot.mbn"]
