# Cinema Audience Forecasting - Improvement Suggestions

## Current Performance
- **Ensemble RMSE**: 25.4057
- **Ensemble MAE**: 19.6865
- **Training samples**: 60,921
- **Test samples**: 6,834

## 🚀 Recommended Improvements (Priority Order)

### 1. **Advanced Feature Engineering** (High Impact)
- [ ] **Movie-specific features**:
  - Movie genre, rating, runtime
  - Days since release (movie age)
  - Movie popularity/buzz metrics
  
- [ ] **External data sources**:
  - Weather data (temperature, rain, etc.)
  - Local events/holidays
  - School vacation periods
  
- [ ] **Theater-level features**:
  - Theater capacity
  - Number of screens
  - Location type (mall, standalone, etc.)
  
- [ ] **Time-based interactions**:
  - Weekend × Month interactions
  - Holiday × Theater interactions

### 2. **Model Enhancements** (Medium-High Impact)
- [ ] **Add CatBoost** to ensemble (3-model ensemble)
- [ ] **Stacking ensemble**: Use predictions as features for meta-model
- [ ] **Try TabNet** (deep learning for tabular data)
- [ ] **Implement cross-validation**: TimeSeriesSplit with 5 folds

### 3. **Hyperparameter Optimization** (Medium Impact)
- [ ] Increase Optuna trials from 30 to 100+
- [ ] Add more ensemble weight combinations
- [ ] Optimize ensemble weights using scipy.optimize
- [ ] Try different objective functions

### 4. **Data Quality** (Medium Impact)
- [ ] Analyze prediction errors to identify patterns
- [ ] Handle outliers differently (winsorization vs removal)
- [ ] Feature selection (remove low-importance features)
- [ ] Check for data leakage

### 5. **Advanced Techniques** (Lower Impact, Higher Complexity)
- [ ] **Multi-task learning**: Predict multiple targets
- [ ] **Quantile regression**: Predict prediction intervals
- [ ] **Neural networks**: LSTM/GRU for time-series
- [ ] **AutoML**: Try AutoGluon or H2O AutoML

## 📊 Quick Wins (Easy to Implement)

1. **Adjust outlier threshold**: Try 95th or 97th percentile instead of 99th
2. **More lag features**: Add 3-day and 21-day lags
3. **Rolling window variations**: Try 3-day, 21-day, 28-day windows
4. **Log transformation**: Try log(audience_count + 1) as target
5. **Different train/validation split**: Try 85/15 or 90/10

## 🔍 Debugging & Analysis

### Check Model Performance by Theater
```python
# Add to notebook to analyze per-theater performance
validation_results = pd.DataFrame({
    'book_theater_id': train_df['book_theater_id'].iloc[split_idx:],
    'actual': y_valid,
    'predicted': y_valid_pred_ensemble
})
validation_results['error'] = abs(validation_results['actual'] - validation_results['predicted'])

# Find theaters with highest errors
theater_errors = validation_results.groupby('book_theater_id')['error'].mean().sort_values(ascending=False)
print("Top 10 theaters with highest prediction errors:")
print(theater_errors.head(10))
```

### Feature Importance Analysis
- Top features are theater ID and datetime (encoded) - these are categorical
- Consider creating more interaction features with these high-importance features

### Temporal Analysis
```python
# Check if errors are time-dependent
validation_results['show_date'] = train_df['show_date'].iloc[split_idx:]
temporal_errors = validation_results.groupby(validation_results['show_date'].dt.date)['error'].mean()
temporal_errors.plot(title='Prediction Error Over Time')
```

## 📈 Expected Impact

| Improvement | Expected RMSE Reduction | Effort |
|-------------|------------------------|--------|
| Add movie features | -2 to -4 | Medium |
| Add weather data | -1 to -2 | High |
| CatBoost ensemble | -0.5 to -1 | Low |
| More Optuna trials | -0.3 to -0.8 | Low |
| Better cross-validation | -0.5 to -1 | Low |
| Feature interactions | -1 to -2 | Medium |

## 🎯 Target Performance

Current: **RMSE = 25.41**
Goal: **RMSE < 20** (20% improvement)

This would require implementing 3-4 of the high-impact improvements above.
