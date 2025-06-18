# Build stage
FROM redhat/ubi9:latest as builder

RUN dnf install -y gcc-c++ cmake make && dnf clean all

WORKDIR /app
COPY . .

RUN mkdir build && cd build && \
    cmake .. && \
    make

# Runtime stage
FROM registry.access.redhat.com/ubi9/ubi

WORKDIR /opt/app
COPY --from=builder /app/build/app .

ENTRYPOINT ["./app"]