# Copyright 2017 The Nuclio Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM golang:1.23.8 as builder

ARG GOARCH=amd64
ARG SRC_DIR=/go/src/github.com/nuclio/uhttpc

# copy source to source dir
COPY go.mod main.go ${SRC_DIR}/

# make the processor binary
RUN mkdir -p /home/nuclio/bin \
    && GOOS=linux GOARCH=${GOARCH} CGO_ENABLED=0 go build -a -installsuffix cgo -ldflags="-s -w" -o /home/nuclio/bin/uhttpc ${SRC_DIR}/main.go

FROM scratch

# just copy the binary
COPY --from=builder /home/nuclio/bin/uhttpc /home/nuclio/bin/uhttpc
