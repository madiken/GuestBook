<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page session="false" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<HTML>
  <HEAD>
    <TITLE>Using jspInit and jspDestroy</TITLE>
  </HEAD>

  <BODY>
    <H1>Using jspInit and jspDestroy</H1>
    <%!
    int number;

    public void jspInit()
    {
      number = 5;
    }

    public void jspDestroy()
    {
      number = 0;
    }
    %>

    <%
    out.println("The number is " + number + "<BR>");
    %>
  </BODY>
</HTML>



