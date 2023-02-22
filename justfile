# par défaut : lance la 1ère recipe, sinon :
default:
  just --list --unsorted

run: check_db
    RUST_LOG=debug \
    cargo run

test: check_db
    cargo test

build: test
    cargo +nightly build --release -Z build-std=std,panic_abort -Z build-std-features=panic_immediate_abort --target x86_64-unknown-linux-gnu

build_musl: test
    RUSTFLAGS='-C target-feature=-crt-static'
    cargo +nightly build --release -Z build-std=std,panic_abort -Z build-std-features=panic_immediate_abort --target x86_64-unknown-linux-musl

clean:
    cargo clean

# TODO select user...
check_db:
    ls ./sqlite/eloran.db
