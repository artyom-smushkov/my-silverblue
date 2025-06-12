## 1. BUILD ARGS
# These allow changing the produced image by passing different build args to adjust
# the source from which your image is built.
# Build args can be provided on the commandline when building locally with:
#   podman build -f Containerfile --build-arg FEDORA_VERSION=40 -t local-image

# SOURCE_IMAGE arg can be anything from ublue upstream which matches your desired version:
# See list here: https://github.com/orgs/ublue-os/packages?repo_name=main
# - "silverblue"
# - "kinoite"
# - "sericea"
# - "onyx"
# - "lazurite"
# - "vauxite"
# - "base"
#
#  "aurora", "bazzite", "bluefin" or "ucore" may also be used but have different suffixes.
ARG SOURCE_IMAGE="sway-atomic"

## SOURCE_SUFFIX arg should include a hyphen and the appropriate suffix name
# These examples all work for silverblue/kinoite/sericea/onyx/lazurite/vauxite/base
# - "-main"
# - "-nvidia"
# - "-asus"
# - "-asus-nvidia"
# - "-surface"
# - "-surface-nvidia"
#
# aurora, bazzite and bluefin each have unique suffixes. Please check the specific image.
# ucore has the following possible suffixes
# - stable
# - stable-nvidia
# - stable-zfs
# - stable-nvidia-zfs
# - (and the above with testing rather than stable)
ARG SOURCE_SUFFIX="-main"

## SOURCE_TAG arg must be a version built for the specific image: eg, 39, 40, gts, latest
ARG SOURCE_TAG="42"


### 2. SOURCE IMAGE
## this is a standard Containerfile FROM using the build ARGs above to select the right upstream image
FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}


### 3. MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

COPY system-files /tmp/system-files
RUN rsync -rvK /tmp/system-files/ / && \
    ostree container commit

COPY add_repositories.sh /tmp/add_repositories.sh

RUN mkdir -p /var/lib/alternatives && \
    /tmp/add_repositories.sh && \
    ostree container commit

COPY install_brew.sh /tmp/install_brew.sh
RUN /tmp/install_brew.sh && \
    ostree container commit
## NOTES:
# - /var/lib/alternatives is required to prevent failure with some RPM installs
# - All RUN commands must end with ostree container commit
#   see: https://coreos.github.io/rpm-ostree/container/#using-ostree-container-commit

RUN rpm-ostree install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && ostree container commit
RUN rpm-ostree install foot stow podman-compose syncthing rofi-wayland swww xdg-desktop-portal-wlr swappy waybar emacs fish && ostree container commit
RUN rpm-ostree install hyprland hypridle hyprcursor hyprlock xdg-desktop-portal-hyprland SwayNotificationCenter && ostree container commit
RUN rpm-ostree install gnome-keyring && ostree container commit
RUN rpm-ostree install mozilla-fira-sans-fonts && ostree container commit
RUN rpm-ostree install lact && ostree container commit
RUN rpm-ostree install xorg-x11-server-Xorg glx-utils mesa-dri-drivers mesa-vulkan-drivers plymouth-system-theme xorg-x11-drv-amdgpu xorg-x11-drv-ati xorg-x11-drv-intel xorg-x11-drv-evdev xorg-x11-drv-libinput xorg-x11-xauth xorg-x11-xinit xset xkill && ostree container commit
RUN rpm-ostree install picom xrandr && ostree container commit
RUN rpm-ostree install qtile qtile-wayland qtile-extras && ostree container commit
RUN rpm-ostree install kernel-tools && ostree container commit
RUN rpm-ostree install gamescope niri xwayland-satellite && ostree container commit
RUN rpm-ostree install qt5ct qt6ct && ostree container commit

COPY setup_services.sh /tmp/setup_services.sh
RUN /tmp/setup_services.sh && \
    ostree container commit
