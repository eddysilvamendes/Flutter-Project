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

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(overviewPageDisplayName, overViewPageRoute),
  MenuItem(productPageDisplayName, productPageRoute),
  MenuItem(contactPageDisplayName, contactPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
