import streamlit 
from calc import add2

streamlit.title('Add app v1.0.0')

firstNumber = streamlit.number_input('Masukkan angka pertama', step=1)
secondNumber = streamlit.number_input('Masukkan angka kedua', step=1)

streamlit.text(f'Hasilnya: {add2(firstNumber, secondNumber)}')