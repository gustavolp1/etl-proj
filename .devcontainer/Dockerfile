FROM ocaml/opam:debian-11-ocaml-4.14

# Install required system packages
USER root
RUN apt-get update && apt-get install -y \
    git curl unzip build-essential m4 pkg-config libsqlite3-dev sqlite3 zlib1g-dev

# Switch to opam user
USER opam
WORKDIR /home/opam/project
