FROM alpine
ARG user=rtorrent
ARG group=rtorrent

RUN apk add --update rtorrent
RUN adduser -D $user $group

COPY .rtorrent.rc /home/$user/.rtorrent.rc
EXPOSE 49155 6881

USER $user:$group
WORKDIR /downloads

CMD  ["rtorrent"]
