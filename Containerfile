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
ARG SOURCE_TAG="latest"


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
RUN rpm-ostree install foot stow podman-compose syncthing swww xdg-desktop-portal-wlr swappy waybar emacs && ostree container commit
RUN rpm-ostree install hyprland hypridle hyprlock SwayNotificationCenter && ostree container commit
RUN rpm-ostree install gnome-keyring xdg-desktop-portal-gnome && ostree container commit
RUN rpm-ostree install mozilla-fira-sans-fonts mozilla-fira-fonts-common && ostree container commit
RUN rpm-ostree install kernel-tools && ostree container commit
RUN rpm-ostree install niri xwayland-satellite wofi && ostree container commit
# RUN rpm-ostree override remove kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra --install kernel-cachyos && ostree container commit
RUN rpm-ostree cliwrap install-to-root && ostree container commit
RUN rpm-ostree override remove kernel kernel-{core,modules,modules-extra} --install kernel-longterm --install kernel-longterm-core --install kernel-longterm-modules --install kernel-longterm-modules-extra && ostree container commit

COPY setup_services.sh /tmp/setup_services.sh
RUN /tmp/setup_services.sh && \
    ostree container commit
