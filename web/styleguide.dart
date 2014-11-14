import 'dart:html';

/// Logic code for "styleguide.html"
void main() {

  ElementList snippets;

  // Create code samples when the page is loaded
  window.onLoad.listen((Event e) {
    createCodeSamples();
    snippets = document.querySelectorAll('.auto-gen-code-snippet');
  });


  // Add a listener to a "Toggle Code Snippets" button.
  final Element snippetToggle = document.querySelector('#snippet-toggle');
  if (snippetToggle != null) {
    snippetToggle.addEventListener('click', (Event e) {
      if (snippets != null) {
        for (var i = 0; i < snippets.length; i++) {
          final Element snippet = snippets[i];
          snippet.classes.toggle('auto-gen-code-visible');
        }
      }
    });
  } else {
    window.console.warn("#snippet-toggle not found");
  }

}

List<Node> getClonedNonTextNodes(Element element) {
  final nonTextNodes = new List<Node>();
  final childNodes = element.childNodes;

  for (var i = 0; i < childNodes.length; i++) {
    final childElement = childNodes[i];

    if (childElement.nodeType != Node.TEXT_NODE) {
      // Found a valid child element
      nonTextNodes.add(childElement.clone(true));
    }
  }

  return nonTextNodes;
}

void beautifyNodes(List<Node> elements) {
  for (var i = 0; i < elements.length; i++) {
    beautifyNode(elements[i], 0);
  }
}

void beautifyNode(Node element, int depth) {
  final childNodes = element.childNodes;
  final singleIndent = '    ';

  var currentDepthSpacing = '';

  for (var i = 0; i < depth; i++) {
    currentDepthSpacing += singleIndent;
  }

  var nextDepthSpacing = currentDepthSpacing + singleIndent;

  for (var j = 0; j < childNodes.length; j++) {
    final childElement = childNodes[j];

    if (childElement.nodeType == Node.TEXT_NODE) {
      final Text childElementAsText = childElement;
      // found a text node
      if (childElementAsText.data.indexOf('\n') >= 0) {
        if (j + 1 < childNodes.length) {
          childElementAsText.data = '\n' + nextDepthSpacing;
        } else {
          childElementAsText.data = '\n' + currentDepthSpacing;
        }
      }
    } else {
      beautifyNode(childElement, depth + 1);
    }
  }
}


void createCodeSamples() {
  final ElementList codeWrappers = document.querySelectorAll('.code-sample');

  for (var i = 0; i < codeWrappers.length; i++) {
    Element codeWrapper = codeWrappers[i];
    var clonedNodes = getClonedNonTextNodes(codeWrapper);

    beautifyNodes(clonedNodes);

    var preElement = document.createElement('pre');
    var codeElement = document.createElement('code');

    for (var j = 0; j < clonedNodes.length; j++) {
      codeElement.appendText(clonedNodes[j].outerHtml);

      if (j + 1 < clonedNodes.length) {
        codeElement.appendText('\n');
      }
    }

    preElement.append(codeElement);
    preElement.classes.add('auto-gen-code-snippet');
    preElement.classes.add('container');

    var clearDiv = document.createElement('div');
    clearDiv.classes.add('clear');

    var parent = codeWrapper.parentNode;

    if (codeWrapper.nextNode != null) {
      parent.insertBefore(preElement, codeWrapper.nextNode);
    } else {
      parent.append(preElement);
    }

    parent.insertBefore(clearDiv, preElement);
  }
}
