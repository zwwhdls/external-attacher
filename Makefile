# Copyright 2017 The Kubernetes Authors.
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

.PHONY: attacher
attacher:
	mkdir -p bin
	CGO_ENABLED=0 GOOS=linux go build -o bin/csi-attacher ./cmd/csi-attacher

.PHONY: image
image: attacher
	#docker build -t juicedata/juicefs-csi-attacher:v4.0.0 -f Dockerfile .
	docker buildx build -t juicedata/juicefs-csi-attacher:v4.0.0 -f Dockerfile --platform linux/amd64,linux/arm64 . --push
