FROM openshift/jenkins-slave-base-centos7

ENV CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.39.0

RUN set -eux; \
    yum install -y file make gcc-c++ openssl-devel postgresql-devel; \
    curl https://static.rust-lang.org/rustup/archive/1.20.2/x86_64-unknown-linux-gnu/rustup-init -sSf > /tmp/rustup-init.sh; \
    echo "e68f193542c68ce83c449809d2cad262cc2bbb99640eb47c58fc1dc58cc30add  /tmp/rustup-init.sh" | sha256sum -c -; \
    chmod +x /tmp/rustup-init.sh; \
    /tmp/rustup-init.sh -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION; \
    chmod -R a+w $CARGO_HOME; \
    rm /tmp/rustup-init.sh; \
    yum clean all -y

USER 1001
