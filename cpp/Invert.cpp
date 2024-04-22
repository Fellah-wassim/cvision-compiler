#include <opencv2/opencv.hpp>

// Function to generate a negative-positive inverted image using OpenCV
cv::Mat generateNegativePositiveInvertedImage(const cv::Mat& inputImg) {
  // Create a new image with the same dimensions as the input image
  cv::Mat invertedImg = cv::Mat::zeros(inputImg.size(), inputImg.type());

  // Iterate through each pixel of the input image
  for (int y = 0; y < inputImg.rows; ++y) {
    for (int x = 0; x < inputImg.cols; ++x) {
      // Invert the pixel value by subtracting it from the maximum value (255)
      invertedImg.at<uchar>(y, x) = 255 - inputImg.at<uchar>(y, x);
    }
  }

  return invertedImg;
}

int main() {
  // Load an example image (replace "input.jpg" with the path to your image)
  cv::Mat inputImage = cv::imread("input.jpg", cv::IMREAD_GRAYSCALE);
  if (inputImage.empty()) {
    std::cerr << "Could not read the image file."<< std::endl;
    return 1;
  }

  // Generate a negative-positive inverted image
  cv::Mat invertedImage = generateNegativePositiveInvertedImage(inputImage);

  // Display the original and inverted images
  cv::imshow("Original Image", inputImage);
  cv::imshow("Inverted Image", invertedImage);
  cv::waitKey(0);

  return 0;
}