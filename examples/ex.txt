#include <opencv2/opencv.hpp>

// Function to generate a negative-positive inverted image using OpenCV
cv::Mat generateNegativePositiveInvertedImage(const cv::Mat& inputImage) {
  // Create a new image with the same dimensions as the input image
  cv::Mat invertedImage = cv::Mat::zeros(inputImage.size(), inputImage.type());
  cv::Mat invertedImage = cv::Mat::zeros(inputImage.size(), inputImage.type());
  cv::imshow("Original Image", inputImage);
  cv::imshow("Inverted Image", invertedImage);
  cv::Mat inputImage = cv::imread("input.jpg");
  ggg = cv::Mat::identifier();
  cv::Mat inputImage = cv::imread("input.jpg", cv::IMREAD_GRAYSCALE);
  cv::Mat invertedImage = generateNegativePositiveInvertedImage(inputImage);
}

int main(){
  cv::imshow("Inverted Image", invertedImage);
}
