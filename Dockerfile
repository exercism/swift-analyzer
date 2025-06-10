FROM swift:6.1.2-noble AS builder
WORKDIR /opt/analyzer
COPY ./Sources/ ./Sources/
COPY ./Package.swift ./Package.resolved ./

# Print Installed Swift Version
RUN swift --version
#RUN swift package clean
RUN swift build --configuration release

FROM swift:6.1.2-noble-slim
RUN apt-get update && apt-get install -y jq
WORKDIR /opt/analyzer
COPY bin/ bin/
COPY --from=builder /opt/analyzer/.build/release/Analyzer bin/

ENTRYPOINT ["./bin/run.sh"]
