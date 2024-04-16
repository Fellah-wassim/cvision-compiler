
// Function to generate a negative-positive inverted image using OpenCV
cv::Mat generateNegativePositiveInvertedImage(const cv::Mat& inputImage) {
  // Create a new image with the same dimensions as the input image
  cv::Mat invertedImage = cv::Mat::zeros(inputImage.size(), inputImage.type());
  cv::Mat invertedImage = cv::Mat::zeros(inputImage.size(), inputImage.type());
  cv::imshow("Original Image", inputImage);
  cv::imshow("Inverted Image", invertedImage);
  cv::Mat inputImage = cv::imread("input.jpg");
  ggg = cv::Mat::identifier();
  ggg = 5;
  cv::Mat inputImage = cv::imread("input.jpg", cv::IMREAD_GRAYSCALE);
  cv::Mat invertedImage = generateNegativePositiveInvertedImage(inputImage);
  if (ggg<sss && ggg>lll){
    int x;
    x = y;
    cv::Mat invertedImage = cv::Mat::zeros(inputImage.size(), inputImage.type());
    cv::Mat invertedImage = cv::Mat::zeros(inputImage.size(), inputImage.type());
    cv::imshow("Original Image", inputImage);
    if(ggg>= sss){
      x = y;
      cv::Mat invertedImage = cv::Mat::zeros(inputImage.size(), inputImage.type());
      cv::Mat invertedImage = cv::Mat::zeros(inputImage.size(), inputImage.type());
    }
  }

  for (int y = 0; y < inputImage.rows; ++y) {
    for (int x = 0; x < inputImage.cols; ++x) {
      x=5;
    }
  }

  for (int y = 0; y < inputImage.rows; ++y){
    x = y;
    cv::Mat invertedImage = cv::Mat::zeros(inputImage.size(), inputImage.type());
    cv::Mat invertedImage = cv::Mat::zeros(inputImage.size(), inputImage.type());
    if(ggg>= sss){
      x = y;
      cv::Mat invertedImage = cv::Mat::zeros(inputImage.size(), inputImage.type());
      cv::Mat invertedImage = cv::Mat::zeros(inputImage.size(), inputImage.type());
    }
  }

}

int main() {
  // Load an example image (replace "input.jpg" with the path to your image)
  cv::Mat inputImage = cv::imread("input.jpg", cv::IMREAD_GRAYSCALE);
  if (inputImage.empty()) {
      std::cerr << "Could not read the image file." << std::endl;
      return 1;
  }

  // Generate a negative-positive inverted image
  cv::Mat invertedImage = generateNegativePositiveInvertedImage(inputImage);

  // Display the original and inverted images
  cv::imshow("Original Image", inputImage);
  cv::imshow("Inverted Image", invertedImage);
  cv::waitKey(0);
  // invertedImage.at<uchar>(y, x)

  return 0;
}