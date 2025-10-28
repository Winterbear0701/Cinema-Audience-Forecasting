# 🚀 Quick Start Guide

## Get Started in 5 Minutes

### Step 1: Activate Environment
```powershell
cd "d:\Projects\Kaggle Challenge"
.\theatre\Scripts\Activate.ps1
```

### Step 2: Open Jupyter Notebook
```powershell
cd Cinema-Audiance\code
jupyter lab working-1.ipynb
```

### Step 3: Run the Pipeline
- Click **Run → Run All Cells**
- Wait 10-15 minutes for completion

### Step 4: Get Your Submissions
After execution completes, you'll find:
- `submission_v1.csv` - LightGBM model
- `submission_ensemble_v1.csv` - **Ensemble model (use this!)**

---

## 🎯 What Happens During Execution

1. ✅ **Data Loading** (30 seconds)
   - Loads 8 CSV files
   - ~300K rows of booking data

2. ✅ **Feature Engineering** (2-3 minutes)
   - Creates 30+ features
   - Lag, rolling, and booking features

3. ✅ **Model Training** (5-8 minutes)
   - Baseline LightGBM
   - Optuna hyperparameter tuning (30 trials)
   - XGBoost training

4. ✅ **Prediction** (1-2 minutes)
   - Generates 38,064 predictions
   - Creates submission files

---

## 📊 Expected Results

### Console Output
```
Train RMSE: ~XX.XX, MAE: ~XX.XX
Val RMSE: ~XX.XX, MAE: ~XX.XX
Ensemble RMSE: ~XX.XX (Best!)
```

### Files Created
```
Cinema-Audiance/
├── submission_v1.csv            # 38,064 rows
└── submission_ensemble_v1.csv   # 38,064 rows ⭐
```

---

## ⚠️ Troubleshooting

### Issue: Kernel Not Found
**Solution:**
```powershell
python -m ipykernel install --user --name=theatre
```

### Issue: Package Import Error
**Solution:**
```powershell
pip install -r requirements.txt
```

### Issue: Memory Error
**Solution:**
- Reduce `n_trials` in Optuna (line ~350)
- Change from 30 to 10 trials

---

## 🎓 Understanding the Output

### Submission Format
```csv
ID,audience_count
book_00001_2024-03-01,125
book_00001_2024-03-02,89
...
```

- **ID**: `book_theater_id` + `_` + `show_date`
- **audience_count**: Predicted audience (integer)

### Evaluation Metric
- **RMSE** (Root Mean Squared Error)
- Lower is better
- Heavily penalizes large errors

---

## 📈 Next Steps

1. **Submit to Kaggle**
   - Use `submission_ensemble_v1.csv`
   - Check leaderboard score

2. **Iterate and Improve**
   - Try different ensemble weights
   - Add more features
   - Tune hyperparameters further

3. **Experiment**
   - Read `README.md` for advanced ideas
   - Try CatBoost, Neural Networks
   - Add external data sources

---

**Happy Kaggling! 🎉**
