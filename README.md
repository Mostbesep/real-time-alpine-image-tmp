# Alpine-based Dockerized Linux Kernel with PREEMPT_RT Patch

This project provides a Docker-based environment to build and run a Linux kernel with the **PREEMPT_RT** (Real-Time) patch applied. The Docker image is based on **Alpine Linux**, making it lightweight and efficient. It includes all the necessary tools and configurations to compile the kernel and apply the real-time patch.

---

## Table of Contents
1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Building the Docker Image](#building-the-docker-image)
4. [Running the Container](#running-the-container)
5. [Verifying the Real-Time Kernel](#verifying-the-real-time-kernel)
6. [Cleaning Up](#cleaning-up)
7. [Contributing](#contributing)
8. [License](#license)

---

## Overview

The goal of this project is to create a portable and reproducible environment for building and testing a Linux kernel with the **PREEMPT_RT** patch. This is particularly useful for developers working on real-time applications, such as industrial control systems, robotics, or multimedia processing.

The Docker image includes:
- A base Alpine Linux environment.
- All necessary tools for kernel compilation.
- The Linux kernel source code and PREEMPT_RT patch.
- Automated steps to configure, compile, and install the real-time kernel.

---

## Prerequisites

Before using this project, ensure you have the following installed on your system:
- **Docker**: Install Docker from the [official website](https://docs.docker.com/get-docker/).
- **Git** (optional): To clone this repository.

---

## Building the Docker Image

1. Clone this repository:
   ```bash
   git clone https://github.com/your-repo/alpine-linux-rt-kernel.git
   cd alpine-linux-rt-kernel
   ```

2. Build the Docker image:
   ```bash
   docker build -t alpine-linux-rt-kernel .
   ```
    - This will create a Docker image named `alpine-linux-rt-kernel`.

---

## Running the Container

Once the Docker image is built, you can run a container from it:
```bash
docker run -it --rm alpine-linux-rt-kernel
```
- This will start an interactive shell inside the container.

---

## Verifying the Real-Time Kernel

To verify that the real-time kernel is installed and running:
1. Check the kernel version:
   ```bash
   uname -r
   ```
    - The output should include the kernel version and the `rt` suffix (e.g., `6.1.0-rt`).

2. Test real-time performance using `cyclictest`:
    - Install `rt-tests` (if not already installed):
      ```bash
      apk add rt-tests
      ```
    - Run `cyclictest`:
      ```bash
      cyclictest -t1 -p80 -n -i 10000 -l 10000
      ```
    - This will measure the latency of the real-time kernel.

---

## Cleaning Up

To remove the Docker image and free up space:
```bash
docker rmi alpine-linux-rt-kernel
```

---

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.

---

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- The Linux Kernel Project: [https://www.kernel.org/](https://www.kernel.org/)
- PREEMPT_RT Patch: [https://wiki.linuxfoundation.org/realtime/start](https://wiki.linuxfoundation.org/realtime/start)
- Docker: [https://www.docker.com/](https://www.docker.com/)
- Alpine Linux: [https://alpinelinux.org/](https://alpinelinux.org/)

---

Enjoy building and testing your real-time Linux kernel with Docker! 🚀
