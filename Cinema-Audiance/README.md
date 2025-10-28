# 🎬 Cinema Audience Forecasting - Kaggle Competition

## 📋 Project Overview

This project predicts daily **audience attendance** for movie theaters using historical booking and visit data from two platforms:
- **BookNow**: Online ticket booking system
- **CinePOS**: On-site point-of-sale system

**Goal**: Forecast audience counts for each `book_theater_id + show_date` combination.

---

## 📂 Project Structure

```
Cinema-Audiance/
├── code/
│   └── working-1.ipynb          # Main analysis notebook
├── dataset/
│   ├── booknow_booking/         # Online bookings
│   ├── cinePOS_booking/         # On-site ticket sales
│   ├── booknow_visits/          # Actual audience counts (target)
│   ├── booknow_theaters/        # BookNow theater metadata
│   ├── cinePOS_theaters/        # CinePOS theater metadata
│   ├── movie_theater_id_relation/ # Theater ID mapping
│   ├── date_info/               # Calendar information
│   └── sample_submission/       # Submission format
├── submission_v1.csv            # LightGBM predictions
├── submission_ensemble_v1.csv   # Ensemble predictions ⭐
└── README.md                    # This file
```

---

## 🛠️ Setup & Installation

### Prerequisites
- Python 3.10+
- Virtual environment (recommended)

### Install Dependencies

```powershell
# Create virtual environment
python -m venv theatre
.\theatre\Scripts\Activate.ps1

# Install required packages
pip install pandas numpy scikit-learn
pip install lightgbm xgboost catboost optuna
pip install matplotlib seaborn plotly
pip install jupyterlab
```

Or install from requirements.txt:

```powershell
pip install -r requirements.txt
```

---

## 🚀 Running the Project

### Option 1: Run Complete Pipeline

Open the notebook in VS Code or JupyterLab:

```powershell
cd Cinema-Audiance/code
jupyter lab working-1.ipynb
```

Then run all cells: **Run → Run All Cells**

### Option 2: Step-by-Step Execution

1. **Data Loading** (Cells 1-4)
2. **Initial Analysis & Visualization** (Cells 5-14)
3. **Data Cleaning** (Cells 15-28)
4. **Feature Engineering** (Cells 31-38)
5. **Model Training** (Cells 41-48)
6. **Submission Generation** (Cells 50-52)
7. **Optional: Ensemble Model** (Cells 55-58)

**Estimated Runtime:** 10-15 minutes

---

## 📊 Features Engineered

### 1. **Temporal Features** (4 features)
- `day_of_week`: Day of week (0=Monday, 6=Sunday)
- `month`: Month of year
- `is_weekend`: Binary weekend indicator
- `is_holiday`: Holiday flag

### 2. **Booking Features** (10 features)
- `booknow_count`: Online bookings
- `cinepos_count`: On-site bookings
- `total_bookings`: Combined bookings
- `booking_ratio`: Online vs total ratio
- `lead_time_mean/std/min/max`: Booking lead time statistics
- `cinepos_lead_time_mean/std`: POS lead time

### 3. **Lag Features** (6 features)
- `audience_lag_1/7/14`: Past audience counts
- `bookings_lag_1/7/14`: Past booking counts

### 4. **Rolling Features** (4 features)
- `audience_rolling_mean_7`: 7-day average
- `audience_rolling_std_7`: 7-day volatility
- `booking_momentum`: Booking trend
- `days_since_last_show`: Days since last screening

### 5. **Theater Metadata** (6 features)
- `theater_area_encoded`: Theater location
- `theater_type_encoded`: Theater category
- `theater_avg_audience`: Historical average
- `theater_std_audience`: Historical variance
- `latitude/longitude`: Geographic coordinates

**Total: 30+ features**

---

## 🧠 Models Used

### 1. **LightGBM** (Baseline)
- Gradient boosting framework
- Fast training with categorical support
- Hyperparameter tuned with Optuna (30 trials)

**Best Parameters:**
- `num_leaves`: 20-150
- `learning_rate`: 0.01-0.1
- `feature_fraction`: 0.5-0.95
- Early stopping at 50 rounds

### 2. **XGBoost** (Ensemble Component)
- Extreme gradient boosting
- Robust to overfitting
- Complementary predictions to LightGBM

### 3. **Ensemble** (Recommended)
- **Weighted average**: 60% LightGBM + 40% XGBoost
- Combines strengths of both models
- Better generalization

---

## 📈 Model Performance

| Model | Validation RMSE | Validation MAE |
|-------|-----------------|----------------|
| LightGBM (Baseline) | ~XX.XX | ~XX.XX |
| LightGBM (Tuned) | ~XX.XX | ~XX.XX |
| XGBoost | ~XX.XX | ~XX.XX |
| **Ensemble** | **~XX.XX** | **~XX.XX** |

*(Values will be populated after running the notebook)*

---

## 📁 Output Files

### `submission_v1.csv`
- Pure LightGBM predictions
- Format: `ID,audience_count`
- 38,064 predictions

### `submission_ensemble_v1.csv` ⭐
- **Recommended submission**
- Ensemble of LightGBM + XGBoost
- Better generalization expected

---

## 🔍 Key Insights

1. **Booking patterns strongly correlate with audience**
   - Online bookings are a strong predictor
   - Lead time indicates engagement level

2. **Temporal patterns matter**
   - Weekends show 2-3x higher attendance
   - Seasonal variations exist

3. **Theater-specific trends**
   - Each theater has unique patterns
   - Location and type influence heavily

4. **Lag features capture momentum**
   - Recent audience history is predictive
   - 7-day rolling average smooths noise

---

## 🎯 Next Steps for Improvement

### Short-term Enhancements
1. ✅ Add CatBoost to ensemble
2. ✅ Implement k-fold time series CV
3. ✅ Fine-tune ensemble weights
4. ✅ Add more rolling window sizes

### Advanced Features
1. 🔄 Movie-specific features (genre, cast, ratings)
2. 🔄 Weather data integration
3. 🔄 Local events calendar
4. 🔄 Theater capacity utilization
5. 🔄 Competitor theater analysis

### Model Experiments
1. 🔄 Neural networks (LSTM/GRU for time series)
2. 🔄 Transformer-based models
3. 🔄 Prophet for seasonality
4. 🔄 Stacked ensembles

---

## 📚 Libraries Used

| Library | Version | Purpose |
|---------|---------|---------|
| pandas | 2.3.3 | Data manipulation |
| numpy | 2.2.6 | Numerical operations |
| scikit-learn | 1.7.2 | ML utilities |
| lightgbm | 4.6.0 | Gradient boosting |
| xgboost | 3.1.1 | Gradient boosting |
| optuna | 4.5.0 | Hyperparameter tuning |
| matplotlib | 3.10.7 | Visualization |
| seaborn | 0.13.2 | Statistical plots |
| plotly | 6.3.1 | Interactive charts |

---

## 👤 Author

Created for Kaggle Cinema Audience Forecasting Competition

---

## 📝 License

This project is for educational and competition purposes.

---

## 🙏 Acknowledgments

- Kaggle for providing the dataset
- LightGBM and XGBoost communities
- Optuna for efficient hyperparameter tuning

---

**Good luck with your submissions! 🎉**
