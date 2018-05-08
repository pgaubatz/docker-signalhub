FROM node:8 as builder
WORKDIR /build
COPY package.json .
RUN npm i && npx pkg .

FROM alpine:3.6
WORKDIR /
COPY --from=builder /build/signalhub .
RUN addgroup -g 1000 node && adduser -u 1000 -G node -s /bin/sh -D node && apk add --no-cache libstdc++
EXPOSE 3000
USER node:node
CMD ["./signalhub", "listen", "-p", "3000"]
