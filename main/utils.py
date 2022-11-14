

def convert_nums_to_arabic(text):
	return text.translate(
		str.maketrans('0123456789', '۰١٢٣٤٥٦٧٨٩')
	)
