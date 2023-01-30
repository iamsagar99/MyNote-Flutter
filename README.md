Form(
key: _formKey,
child: Padding(
padding: EdgeInsets.all(16),
child: Column(
children: <Widget>[
TextFormField(
decoration: InputDecoration(labelText: 'Book Name'),
validator: (value) {
if (value == null) {
return 'Please enter book name';
}
return null;
},
onSaved: (value) => bookName = value!,
),
TextFormField(
decoration: InputDecoration(labelText: 'Book Author'),
validator: (value) {
if (value == null) {
return 'Please enter book author';
}
return null;
},
onSaved: (value) => bookAuthor = value!,
),
TextFormField(
decoration: InputDecoration(labelText: 'Book Description'),
validator: (value) {
if (value==null) {
return 'Please enter book description';
}
return null;
},
onSaved: (value) => bookDescription = value!,
),
//for book
Container(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
ElevatedButton(onPressed: (){
pickFile();
}, child: Text("Upload a Book")),
if(pickedFile!=null)
Icon(Icons.check, color: Colors.green),
],
),
],
),
),





              // for thumbnail
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: isLoadingtb
                          ? CircularProgressIndicator()
                          :ElevatedButton(onPressed: (){
                        pickFile();
                      }, child: Text("Upload thumbnail")),
                    ),
                    if(pickedFiletb!=null)
                      SizedBox(height: 50, width: 50, child: Image.file(fileToDisplaytb!)),
                  ],
                ),
              ),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print(bookName);
                    print(bookAuthor);
                    print(bookDescription);
                    // Submit the form and perform desired actions
                  }
                },
              ),
            ],
          ),
        ),
      ),
