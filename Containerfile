FROM ghcr.io/ublue-os/fedora-distrobox

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="nerdy0901"

RUN echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf 

COPY extra-packages /
RUN dnf upgrade --assumeyes && \
    grep -v '^#' /extra-packages | xargs dnf install --assumeyes
RUN rm /extra-packages

RUN   ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
     
RUN dnf copr enable --assumeyes atim/starship && \
    dnf install --assumeyes starship