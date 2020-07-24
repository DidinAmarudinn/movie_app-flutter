class GenresModel{
  String name;
  String imgUrl;
  String id;
  GenresModel({
    this.id,
    this.name,
    this.imgUrl
  });
}

List<GenresModel> genres=[
  GenresModel(id: "28", name: "Action", imgUrl: "https://images.unsplash.com/photo-1579803815615-1203fb5a2e9d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"),
  GenresModel(id: "12", name: "Adventure", imgUrl: "https://images.unsplash.com/photo-1579935110378-81262796945f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
  GenresModel(id: "16", name: "Animation", imgUrl: "https://images.unsplash.com/photo-1569701813229-33284b643e3c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
  GenresModel(id: "35", name: "Comedy", imgUrl: "https://images.unsplash.com/photo-1485846234645-a62644f84728?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
  GenresModel(id: "14", name: "Fantasy", imgUrl: "https://images.unsplash.com/photo-1551039226-821e296bdd9d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80"),
  GenresModel(id: "10749", name: "Romance", imgUrl: "https://images.unsplash.com/photo-1485199433301-8b7102e86995?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),

];