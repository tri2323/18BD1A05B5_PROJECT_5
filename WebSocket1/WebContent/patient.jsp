<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Patient Portal</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<div class="row row-content d-flex align-items-center justify-content-center">
	<div class="container">
		<br><br><br>
		<form>
		<div class="form-group row">
		<label class="col-12 col-sm-2" for="vital">Enter Oxygen Levels:</label>
		<div class="col-12 col-sm-4">
		<input class="form-control form-control-sm" onChange="checkOxygen()" type="text" name="vital" id="vital">
		</div>
		</div>
		<div class="form-group row">
		<label class="col-12 col-sm-2" for="vital1">Enter Temperature:</label>
		<div class="col-12 col-sm-4">
		<input class="form-control form-control-sm" type="text" name="vital1" id="vital1">
		</div>
		</div>
		<div class="form-group row">
		<label class="col-12 col-sm-2" for="vital2">Enter Contact Number:</label>
		<div class="col-12 col-sm-4">
		<input class="form-control form-control-sm" type="text" onChange="checkNumber()" name="vital2" id="vital2"><br>
		</div>
		</div>
		<div class="form-group row">
		<div class="col-sm-3 col offset-0 offset-sm-2">
		<!--  <button  onclick="sendVitals();" class="btn btn-success btn-sm">Submit</button>  -->
		<input onclick="sendVitals()" name="submit" type="button" value="Submit" class="btn btn-primary">  
		</div>
		</div>
		</form>
		<br /><br />
		<table id="example" class="table">
			<thead>
				<tr>
					<th>Doctor</th>
					<th>Medicine</th>
					<th>Description</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				</tr>
			</tbody>
		</table>
	</div>
</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<script>
		function checkNumber(){
			var regex=/^[6789][0-9]{9}$/;
			var mobile=document.getElementById("vital2");
			console.log("contact "+(mobile.value.match(regex)));
			if(!(mobile.value.match(regex))){
				alert("Enter correct phone number with 10 digits");
			}
		}
		function checkOxygen(){
			var o2=document.getElementById("vital").value;
			console.log("oxygen "+o2);
			if(o2<0 || o2>100){
				alert("Enter correct oxygen levels..");
			}
		}
	</script>
	<script>
		var websocket=new WebSocket("ws://localhost:8080/WebSocket1/VitalCheckEndPoint");
		websocket.onmessage=function processVital(vital){
			var jsonData=JSON.parse(vital.data);
			if(jsonData.message!=null)
			{
				var details=jsonData.message.split(',');
				var row=document.getElementById('example').insertRow();
				if(details.length>2)
				{
					row.innerHTML="<td>"+details[0]+"</td><td>"+details[1]+"</td><td>"+details[2]+"</td>";		
				}
				else
				{
					alert(details[0]+" has summoned an ambulance");
					row.innerHTML="<td>"+details[0]+"</td><td></td><td>"+details[1]+"</td>";		
				}
			}
		}
		function sendVitals()
		{
			//alert(vital.value);
			//alert(vital1.value;
			//console.log(vital.value+','+vital1.value+','+vital2.value)
			websocket.send(vital.value+','+vital1.value+','+vital2.value);
			vital.value="";
			vital1.value="";
			vital2.value="";
		}
	</script>
</body>
</html>