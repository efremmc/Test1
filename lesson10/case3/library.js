/*
   New Perspectives on XML
   Tutorial 10
   Case Problem 3

   Filename: library.js

   Global Variables:
   DOMPID
      An array contain the program IDs of MSXML ActiveX Objects for creating
      XML documents

   FreeThreadPID
      An array contain the program IDs of MSXML ActiveX Objects for creating
      free-threaded XML documents

   TemplatePID
      An array contain the program IDs of MSXML ActiveX Objects for creating
      XML template documents

   Functions List:
   getPID(pArray)
      Returns the most recent program ID supported by the current browser.

   loadDoc(document, file)
      Synchronously loads an XML or XSLT file into the document object

   extractFName(path)
      Extracts the filename from a path string.

   removeWhiteSpaceNodes(node)
      Removes all white space text nodes contained within the specified node.

*/

var DOMPID =        ["Msxml2.DOMDocument.5.0", 
                     "Msxml2.DOMDocument.4.0",
                     "Msxml2.DOMDocument.3.0", 
                     "MSXML2.DOMDocument", 
                     "Microsoft.XMLDOM"];

var FreeThreadPID = ["Msxml2.FreeThreadedDOMDocument.5.0",
                     "Msxml2.FreeThreadedDOMDocument.4.0",
                     "Msxml2.FreeThreadedDOMDocument.3.0"];

var TemplatePID =   ["Msxml2.XSLTemplate.5.0",
                     "Msxml2.XSLTemplate.4.0",
                     "Msxml2.XSLTemplate.3.0"];

function getPID(pArray) {
   var PIDStr = "";
   var PIDFound = false;
   for (i=0; i<pArray.length && !PIDFound; i++) {
      try {
         var objectXML=new ActiveXObject(pArray[i]);
         PIDStr=pArray[i];
         PIDFound=true;
      } catch (objException) {
      }
   }
   return PIDStr;
}

function loadDoc(document, file) {
   document.async=false;
   document.load(file);
}

function extractFName(path) {
   i=path.lastIndexOf("\\");
   if (i==-1) i=path.lastIndexOf("/");
   return path.substring(i+1);
}

function removeWhiteSpaceNodes(node) {
   var noWhiteSpace = /\S/;
   for (var i=0; i < node.childNodes.length; i++) {
      testNode = node.childNodes[i];
      if (testNode.nodeType==3 && !noWhiteSpace.test(testNode.nodeValue)) {
         node.removeChild(testNode);
         i--;
      }
      if (testNode.nodeType==1) {
         removeWhiteSpaceNodes(testNode);
      }
   }
}