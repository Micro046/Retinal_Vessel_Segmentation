
# Improved Retinal Vessel Segmentation using UNET

## 📄 Abstract

Diabetic retinopathy is a leading cause of blindness, and early detection is vital to prevent vision loss. This project proposes an improved deep learning framework for segmenting thick and thin retinal blood vessels using **UNET**. The architecture segments thin and thick vessels separately and fuses the outputs for a more accurate binary segmentation map.

🔗 **Read the full paper here:** [Improved Retinal Vessel Segmentation using UNET (PDF)](https://drive.google.com/file/d/1nLBaWSpJE8SqIQvaecUt61AaZQV6VG7k/view?usp=drive_link)

---

## 🧠 Methodology

* **Dual Training**: Thick and thin vessels are segmented separately using separate training objectives.
* **Exemplar-Based Inpainting**: To restore non-vessel regions for better differentiation.
* **Fusion Strategy**: Combines multiple probability maps for final segmentation.
* **UNET Architecture**: Encoder-decoder design with skip connections for detailed semantic segmentation.
* **Loss Optimization**: Weighted loss maps to prioritize challenging pixel regions (thin vessels).

---

## 🗂 Dataset

* **Dataset Used**: [DRIVE]
* **Images**: 40 retinal fundus images (565×584 resolution)
* **Split**: 20 training and 20 testing images
* **Preprocessing**: Data augmentation using Horizontal/Vertical flips, Elastic/Optical transformations, and Dropout.

---

## 📊 Evaluation Metrics

* **Accuracy**
* **Precision**
* **Sensitivity (Recall)**
* **F1 Score**

| Method   | Accuracy (%) | Sensitivity (%) |
| -------- | ------------ | --------------- |
| UNET     | 94.52        | 70.71           |
| AG-UNET  | 95.99        | 82.01           |
| DenseNet | 96.04        | 84.49           |
| **Ours** | **96.42**    | **97.14**       |

---

## 📈 Results

* Our model performs better in **segmenting thin vessels**, which are typically missed or partially detected by traditional UNET and other methods.
* Outperforms baselines in sensitivity and maintains high accuracy even in low-contrast images.

### 🔍 Final Segmentation Result

The image below shows the comparison of segmentation outputs:

* **Left**: Ground Truth
* **Center**: UNET Result
* **Right**: Our Method Result

As seen, our method captures significantly more thin vessels, especially those missed by the standard UNET approach.

![Final Result](https://github.com/Micro046/Retinal_Vessel_Segmentation/raw/main/final_result.png)

---

## 🧪 Experimental Setup

* **Model**: UNET
* **Learning Rate**: 1e-6
* **Optimizer**: Adam
* **Dropout**: 0.25
* **Batch Size**: 2
* **Epochs**: 100
* **Augmentations**: Albumentations library (Flip, Distortion, Dropout)
* **Training Device**: GPU

---

## ✅ Conclusion

We present a segmentation framework that significantly enhances the detection of **thin vessels** by training them independently and fusing multiple maps. The proposed method is robust, performs well under low-contrast conditions, and is suitable for **automated diabetic retinopathy screening** in real-world applications.

---

## 📚 References

A comprehensive list of academic references is provided in the full paper. Key works include UNET, LadderNet, DenseNet, and various deep learning segmentation techniques.

---

## 📎 Link to Paper

👉 [Download Full PDF](https://drive.google.com/file/d/1nLBaWSpJE8SqIQvaecUt61AaZQV6VG7k/view?usp=drive_link)

---
