OPENCV_VERSION := $(shell grep OPENCV_VERSION .version | cut -d '=' -f '2')
CUDA_VERSION := $(shell grep GOLANG_VERSION .version | cut -d '=' -f 2)
GOLANG_VERSION := $(shell grep GOLANG_VERSION .version | cut -d '=' -f 2)
PLATFORM := linux/amd64,linux/arm64

opencv-cuda-runtime:
	docker buildx build --push --platform=${PLATFORM}	\
		--file=opencv-cuda_runtime-ubuntu.Dockerfile \
		--tag=bryantrh/opencv-cuda-runtime:${OPENCV_VERSION}-${CUDA_VERSION}-ffmpeg	\
		--build-arg=OPENCV_VERSION=${OPENCV_VERSION}	\
		--build-arg=OPENCV_VERSION=${CUDA_VERSION}	\
		.

opencv-cuda-devel:
	docker buildx build --push --platform=${PLATFORM}	\
		--file=opencv-cuda_devel-ubuntu.Dockerfile \
		--tag=bryantrh/opencv-cuda-devel:${OPENCV_VERSION}-${CUDA_VERSION}-ffmpeg	\
		--build-arg=OPENCV_VERSION=${OPENCV_VERSION}	\
		--build-arg=OPENCV_VERSION=${CUDA_VERSION}	\
		.

gocv:
	docker buildx build --push --progress plain \
		--platform=${PLATFORM} \
		--file=gocv-ubuntu.Dockerfile \
		--tag=bryantrh/gocv-cuda-ubuntu:${GOLANG_VERSION}-${CUDA_VERSION}-ffmpeg \
		--build-arg=GOLANG_VERSION=${GOLANG_VERSION}	\
		--build-arg=OPENCV_VERSION=${CUDA_VERSION}	\
		.

