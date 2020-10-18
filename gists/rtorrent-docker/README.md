# [rTorrent] in Docker

Start

    ./bin/build-and-run ~/Downloads

- Expects `~/Downloads` to have `.torrent/` and `.session/` directories.
- Place `*.torrent` files in the `.torrent/` directory and rTorrent will start downloading.

Start shell

    docker run -it --rm my-rtorrent ash

[rTorrent]: https://github.com/rakshasa/rtorrent
