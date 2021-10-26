import streamlit as st
import numpy as np
import time
import pandas as pd

st.title('This is my first app from Galileo Master!')

#Writing on screen example
x = 4
st.write(str(x), '^2 = ', str(x**2))
x, ' square is ', x**2


#Dataframe on screen example
st.write('This is a dataframe exaple')
st.write(pd.DataFrame({'Column A': ['A', 'B', 'C', 'D', 'E'], 'Column B': [1, 2, 3, 4, 5]}))


#Markdown
'''
# Title: This is a title tag
This is other example for dataframes
'''

df = pd.DataFrame({'Column A': ['A', 'B', 'C', 'D', 'E'], 'Column B': [1, 2, 3, 4, 5]})
df


'''
## Show me some graphs
'''

df_to_plot = pd.DataFrame(
    np.random.randn(20, 3), columns = ['Column A', 'Column B', 'Column C']
)

st.line_chart(df_to_plot)


'''
## Let's plot a map!
'''

df_lat_lon = pd.DataFrame(
    np.random.randn(1000, 2)/[50, 50] + [37.76, -122.4],
    columns = ['lat', 'lon']
)

st.map(df_lat_lon)

if st.checkbox('show dataframe'):
    df_lat_lon


'''
## Let's try some widgets

### 1. Slider
'''

x = st.slider('Select a value for X', min_value = 1, max_value = 100, value = 4)
y = st.slider('Select a power for X', min_value = 0, max_value = 5, value = 2)
st.write(str(x), '^ {} = '.format(y), str(x**y))


'''
### 2. What about options
'''

def test():
    st.write('Funcion ejecutada!')


option_list = range(1, 11)
option = st.selectbox('Which number do you like best?', options = option_list, on_change = test)
st.write('Your favorite number is {}'.format(option))


'''
## 3. How about a progress bar
'''

label = st.empty()
progress_bar = st.progress(0)

for i in range(0, 101, 5):
    label.text('The value is: {}%'.format(i))
    progress_bar.progress(i)
    time.sleep(0.1)

st.write('The wait is done!')


'''
### A sidebar
'''

st.sidebar.write('This is a sidebar')
option_side = st.sidebar.selectbox('Select a slide number:', options = option_list)
st.sidebar.write('The selection is: {}'.format(option_side))

st.sidebar.write('Another slider')
another_slider = st.sidebar.slider('Select range', min_value = 0.0, max_value = 100.0, value = (25.0, 75.0))
st.sidebar.write('The range selected is: ', another_slider)