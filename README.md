# Object Removal by Exemplar-Based Inpainting (Criminisi Algorithm)

This project implements the exemplar-based inpainting algorithm proposed in the paper *"Object Removal by Exemplar-Based Inpainting"* by Criminisi et al. The goal of this algorithm is to remove objects from images and fill the missing regions in a visually plausible way by utilizing surrounding image data.

## Files

### 1. `main.m`
This is the main script that initiates the image inpainting process. It loads the original image (`hua.bmp`) and the corresponding mask image (`huamask.bmp`), where the mask defines the region to be inpainted. The script specifies parameters like the patch size (`qukuai_size`) and the color of the fill region (`fillColor`).

- **Inputs**: 
  - `hua.bmp` (Original image)
  - `huamask.bmp` (Mask image)
  
- **Outputs**:
  - Displays the original image, the masked image, and the inpainted result.
  - Outputs the PSNR (Peak Signal-to-Noise Ratio) for quality evaluation.

### 2. `RGB_Criminisi.m`
This function implements the core of the inpainting algorithm. It calculates the isophote, the gradient, and initializes the confidence and data terms, iteratively updating them while searching for the best-matching patches in the image to fill the missing region.

- **Inputs**: 
  - `imagepath`: The original image to be inpainted.
  - `maskpath`: The mask image indicating the damaged regions.
  - `fillColor`: RGB value defining the damaged region.
  - `qukuai_size`: Patch size for filling missing regions.

- **Outputs**:
  - `Psnr`: Peak Signal-to-Noise Ratio between the original and inpainted images.
  - `inpaintedImg`: The inpainted image.

### 3. `PSNR.m`
This script calculates the PSNR value between the original image and the inpainted image to evaluate the quality of the inpainting process. PSNR is computed across all three color channels (R, G, B).

### 4. `img2ind.m` and `ind2img.m`
These utility functions handle the conversion between RGB images and index images, which are used during the patch-matching and inpainting process.

- `img2ind.m`: Converts an RGB image into an index image.
- `ind2img.m`: Converts an index image back into an RGB image after patch filling.

### 5. `qukuai_9.m`
This function generates the coordinates for the patch centered at a given pixel in the damaged region. It helps to extract the region for which the algorithm will search for a matching patch.

### 6. `whole_match.m`
This function performs a global search to find the best matching patch in the undamaged region of the image. It compares the known pixels in the target patch with candidate patches and finds the one with the least error.

### 7. `form_patch.m`
This function assists in generating the pixel indices for a given patch, which helps in copying pixel data from one part of the image to another.

## How to Run

1. Place the images (`hua.bmp` and `huamask.bmp`) in the same directory as the code files.
2. Open MATLAB and navigate to the directory containing the code files.
3. Run the `main.m` script:
   ```matlab
   main
   ```
4. The inpainting process will start, and the original image, masked image, and the inpainted result will be displayed. The PSNR value will also be printed in the MATLAB console.

## Dependencies

- MATLAB R2020b or later.
- Image Processing Toolbox (for image reading and display).

## Notes

- Adjust the `qukuai_size` parameter in `main.m` to control the size of the patches used during the inpainting process.
- Ensure the fill region is clearly marked in `huamask.bmp` using the `fillColor` value.
- This implementation uses a global search strategy (`whole_match.m`) to find the best matching patch from the undamaged regions.

## References

- Criminisi, Antonio, Patrick Pérez, and Kentaro Toyama. "Object removal by exemplar-based inpainting." *Proceedings of the 2003 IEEE Computer Society Conference on Computer Vision and Pattern Recognition*. Vol. 2. IEEE, 2003.
