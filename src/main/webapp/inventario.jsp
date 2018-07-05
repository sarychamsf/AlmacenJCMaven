<%-- 
    Document   : inventario
    Created on : Jun 21, 2018, 11:54:20 PM
    Author     : Sary
--%>

<%@page import="dao.StockDAO"%>
<%@page import="dao.ProductoDAO"%>
<%@page import="modelo.Stock"%>
<%@page import="modelo.Producto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Inventario</title>

        <!-- Bootstrap Core CSS -->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <!-- MetisMenu CSS -->
        <link href="vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

        <!-- DataTables CSS -->
        <link href="vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

        <!-- DataTables Responsive CSS -->
        <link href="vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="dist/css/sb-admin-2.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>

    <%
        HttpSession misession = request.getSession();

        if (misession.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
        }
    %>

    <body>

        <div id="wrapper">

            <!-- Navigation -->
            <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="inventario.jsp">Almacén</a>
                </div>
                <!-- /.navbar-header -->

                <ul class="nav navbar-top-links navbar-right">
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <center>
                                <li>
                                    <form method="POST" action="Logout">
                                        <button type="submit" name="logout" value="logout" class="btn btn-default" style="border: none;"><i class="fa fa-sign-out fa-fw"></i> Cerrar Sesión </button>
                                    </form>
                                </li>
                            </center>
                        </ul>
                        <!-- /.dropdown-user -->
                    </li>
                    <!-- /.dropdown -->
                </ul>
                <!-- /.navbar-top-links -->

                <div class="navbar-default sidebar" role="navigation">
                    <div class="sidebar-nav navbar-collapse">
                        <ul class="nav" id="side-menu">

                            <li>
                                <a href="inventario.jsp"><i class="fa fa-archive fa-fw"></i> Inventario</a>
                            </li>
                            <li>
                                <a href="registrodiario.jsp"><i class="fa fa-money fa-fw"></i> Registro Diario</a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-edit fa-fw"></i> Productos<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="crearproducto.jsp">Crear</a>
                                    </li>
                                    <li>
                                        <a href="modificarproducto.jsp">Modificar</a>
                                    </li>
                                    <li>
                                        <a href="eliminarproducto.jsp">Eliminar</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-table fa-fw"></i> Compras<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="registrarcompras.jsp">Registrar Compras</a>
                                    </li>
                                    <li>
                                        <a href="vercompras.jsp">Ver Compras</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> Ventas<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="registrarventas.jsp">Registrar Ventas</a>
                                    </li>
                                    <li>
                                        <a href="verventas.jsp">Ver Ventas</a>
                                    </li>
                            </li>
                        </ul>
                        <li>
                            <a href="#"><i class="fa fa-minus-circle fa-fw"></i> Gastos<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="registrargastos.jsp">Registrar Gastos</a>
                                </li>
                                <li>
                                    <a href="vergastos.jsp">Ver Gastos</a>
                                </li>
                        </li>
                        </ul>

                    </div>
                    <!-- /.sidebar-collapse -->
                </div>

            </nav>

            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Inventario</h1>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Inventario de Productos:
                            </div>
                            <!-- /.panel-heading -->
                            <div class="panel-body">
                                <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>Nombre</th>
                                            <th>Precio Unitario</th>
                                            <th>Cantidad Disponible</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <% 
                                            StockDAO stockdao = new StockDAO();
                                            ArrayList<Stock> stocks = stockdao.getAllStock();

                                            Locale.setDefault(Locale.US);
                                            DecimalFormat num = new DecimalFormat("#,###.00");                                            
                                            
                                            for (int i = 0; i < stocks.size(); i++) {
                                                
                                                Stock stock = stocks.get(i);
                                                String nombre = stock.getNombre();
                                                float cantidad = stock.getCantidad();
                                                String cantidads = num.format(cantidad);
                                                
                                                ProductoDAO prodao = new ProductoDAO();
                                                Producto producto = prodao.getProductoById(nombre);
                                                        
                                                float precio = producto.getPrecio(); 
                                                String precios = num.format(precio);

                                        %>

                                        <tr class="odd gradeA">
                                            <td><%=nombre%></td>
                                            <td><%=precios%></td>
                                            <td><%=cantidads%></td>                                                                               
                                        </tr>


                                        <%
                                            }
                                        %>

                                    </tbody>
                                </table>
                                <!-- /.table-responsive -->

                            </div>
                            <!-- /.panel-body -->
                        </div>
                        <!-- /.panel -->
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->

            </div>
            <!-- /.row -->

        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="vendor/metisMenu/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="vendor/datatables-responsive/dataTables.responsive.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="dist/js/sb-admin-2.js"></script>

    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <script>
                                                    $(document).ready(function () {
                                                        $('#dataTables-example').DataTable({
                                                            responsive: true
                                                        });
                                                    });
    </script>

    <script>
        function cancelar() {
            //location.reload();
            document.getElementById('seccionmod').style.display = 'none';
            document.getElementById('modificar').style.display = 'block';
            document.getElementById('cancelar').style.display = 'block';
        }
    </script>

    <script>
        function modificar() {
            document.getElementById('seccionmod').style.display = 'block';
            document.getElementById('modificar').style.display = 'none';
            document.getElementById('cancelar').style.display = 'none';
        }
    </script>

</body>

</html>
