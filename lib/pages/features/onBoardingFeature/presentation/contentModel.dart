class ContentModel {
 final String image;
 final String title;
 final String subtitle;
 final String description;

  ContentModel({required this.image,required this.title,required this.subtitle,required this.description});
}

List<ContentModel> contents = [
  ContentModel(  
    image: "assets/food5.png",
    title:  "Welcome to Zameer Ansari",
    description:  "Zameer Ansari is a food restaurant that offers a unique and delightful dining experience. It is known for its rich and diverse cuisine, prepared by experienced chefs using the finest ingredients.", subtitle: ''
  ),
  ContentModel(  
    image: "assets/food2.png",
    title:  "Chef's Favourite",
    description:  "Choosing the right food meal can make all the difference in your day.", subtitle: 'Specail BBQ Platter'
  ),
  ContentModel(  
    image: "assets/bike.png",
    title:  "Restaurant at your doorstep!",
    description:  "Ordering food at your doorstep has never been easier with our food ordering app.You can now enjoy your favorite meals on just a click.", subtitle: ''
  ),
];
