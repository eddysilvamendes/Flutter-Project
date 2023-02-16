const rootRoute = "/";

List sideMenuItems = [
  overViewPageRoute,
  productPageRoute,
  contactPageRoute,
  authenticationPageRoute,
];
const overviewPageDisplayName = "Overview";
const overViewPageRoute = "/overview";

const productPageDisplayName = "Products";
const productPageRoute = "/products";

const contactPageDisplayName = "Contacts";
const contactPageRoute = "/contact";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

const categoryPageDisplayName = "Category";
const categoryPageRoute = "/category";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(overviewPageDisplayName, overViewPageRoute),
  MenuItem(productPageDisplayName, productPageRoute),
  MenuItem(contactPageDisplayName, contactPageRoute),
  MenuItem(categoryPageDisplayName, categoryPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
