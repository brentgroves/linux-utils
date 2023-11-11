WORKDIR /install/mongodb
COPY ./install/mongodb/libssl1.1_1.1.1f-1ubuntu2_amd64.deb .
RUN dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb

Plex python zeep needs version 1.1 so does mongodb
