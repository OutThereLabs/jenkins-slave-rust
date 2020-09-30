FROM openshift/jenkins-slave-base-centos7

ENV CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.45.2

RUN set -eux; \
    yum install -y file make gcc-c++ openssl-devel postgresql-devel; \
    curl https://static.rust-lang.org/rustup/archive/1.22.1/x86_64-unknown-linux-gnu/rustup-init -sSf > /tmp/rustup-init.sh; \
    echo "49c96f3f74be82f4752b8bffcf81961dea5e6e94ce1ccba94435f12e871c3bdb  /tmp/rustup-init.sh" | sha256sum -c -; \
    chmod +x /tmp/rustup-init.sh; \
    /tmp/rustup-init.sh -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION; \
    chmod -R a+w $CARGO_HOME; \
    rm /tmp/rustup-init.sh; \
    yum clean all -y

USER 1001
