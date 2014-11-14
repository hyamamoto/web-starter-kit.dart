part of wsk;

void _initMenuBar() {
  final query = document.querySelector;
  final removeOpen = (Element e) => e != null ? e.classes.remove('open'): false;
  final toggleOpen = (Element e) => e != null ? e.classes.toggle('open'): false;

  Element navdrawerContainer = query('.navdrawer-container');
  Element body = document.body;
  Element appbarElement = query('.app-bar');

  void closeMenu(Event e) {
    removeOpen(body);
    removeOpen(appbarElement);
    removeOpen(navdrawerContainer);
  }

  void toggleMenu(Event e) {
    toggleOpen(body);
    toggleOpen(appbarElement);
    toggleOpen(navdrawerContainer);
    if (navdrawerContainer != null)
      navdrawerContainer.classes.add('opened');
  }

  bool addClickListener(String name, EventListener l) {
    final Element elem = query(name);
    final bool found = elem != null;
    if (found)
      elem.addEventListener('click', l);
    return found;
  }

  // 'click' for #main
  if (!addClickListener('main', closeMenu)){
    window.console.error("material_asset: <main></main> not found");
  }

  // 'click' for .menu
  addClickListener('.menu', toggleMenu);
  
  // 'click' for .navdrawer-container
  addClickListener('.navdrawer-container', (event) {
    if (event.target.nodeName == 'A' || event.target.nodeName == 'LI') {
      closeMenu(event);
    }
  });
}
