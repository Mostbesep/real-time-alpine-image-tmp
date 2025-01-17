# Use Alpine Linux as the base image
FROM alpine:latest

# Install kernel compilation prerequisites
RUN apk update && \
    apk add --no-cache \
    build-base \
    ncurses-dev \
    bison \
    flex \
    openssl-dev \
    elfutils-dev \
    wget \
    xz \
    git \
    kmod \
    bash \
    grub \
    && rm -rf /var/cache/apk/*

# Download the kernel source code
ARG KERNEL_VERSION=6.1
RUN wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${KERNEL_VERSION}.tar.xz && \
    tar xvf linux-${KERNEL_VERSION}.tar.xz && \
    rm linux-${KERNEL_VERSION}.tar.xz

# Download and apply the PREEMPT_RT patch
RUN wget https://cdn.kernel.org/pub/linux/kernel/projects/rt/${KERNEL_VERSION}/patch-${KERNEL_VERSION}-rt.patch.xz && \
    unxz patch-${KERNEL_VERSION}-rt.patch.xz && \
    cd linux-${KERNEL_VERSION} && \
    patch -p1 < ../patch-${KERNEL_VERSION}-rt.patch

# Configure and compile the kernel
WORKDIR /linux-${KERNEL_VERSION}
RUN make defconfig && \
    echo "CONFIG_PREEMPT_RT=y" >> .config && \
    make -j$(nproc) && \
    make modules_install && \
    make install

# Clean up temporary files
RUN rm -rf /linux-${KERNEL_VERSION} /patch-${KERNEL_VERSION}-rt.patch

# Set the new kernel as the default
RUN grub-mkconfig -o /boot/grub/grub.cfg

# Default command to run the container
CMD ["/bin/bash"]