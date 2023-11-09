FROM quay.io/toolbx-images/archlinux-toolbox:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="nerdy0901"

COPY extra-packages /
RUN pacman -Syu --noconfirm && \
    pacman -S --needed --noconfirm git base-devel && \
    git clone https://aur.archlinux.org/yay-bin.git /yay-bin && \
    cd yay-bin && makepkg -si --noconfirm && \
    grep -v '^#' /extra-aur-packages | xargs yay -S --needed --noconfirm &&
RUN rm /extra-packages && \
    rm /yay-bin


RUN   ln -fs /bin/sh /usr/bin/sh && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
     
