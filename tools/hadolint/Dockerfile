FROM alpine:3.7
RUN wget "https://github.com/hadolint/hadolint/releases/download/v1.7.2/hadolint-$(uname -s)-$(uname -m)" -O /usr/local/bin/hadolint && chmod 700 /usr/local/bin/hadolint
ENTRYPOINT ["hadolint"]