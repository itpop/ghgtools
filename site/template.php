<?php
    // Fred Yang. 2016-10-06
	include "base.php";
	include "global.php";

	$scenarioYear = '2015';
	$transport = 0;
	$rsWT = NULL_VALUE;  // stores dataset: source by composition w/o transportation
	$rsTO = NULL_VALUE;  // stores dataset: source by composition with transportation only
	$rsDC = NULL_VALUE;  // stores dataset: destination by composition
	$rsSRC = NULL_VALUE; // stores dataset: sources
	$rsDEST = NULL_VALUE; //stores dataset: destinations
	$rsCOMP = NULL_VALUE; //stores dataset: compositions

	// retrieve $rsSRC
	$params = array(array(&$rsSRC, SQLSRV_PARAM_INOUT));
	$sql = "EXEC dbo.spGetSource @result=?";
	$stmt = sqlsrv_prepare($con, $sql, $params);
	if($stmt && sqlsrv_execute($stmt)) {
		sqlsrv_next_result($stmt);
		sqlsrv_free_stmt($stmt);
	}
	else {
		die(print_r(sqlsrv_errors(), true));
	}
	
	// retrieve $rsDEST
	$params = array(array(&$rsDEST, SQLSRV_PARAM_INOUT));
	$sql = "EXEC dbo.spGetDestination @result=?";
	$stmt = sqlsrv_prepare($con, $sql, $params);
	if($stmt && sqlsrv_execute($stmt)) {
		sqlsrv_next_result($stmt);
		sqlsrv_free_stmt($stmt);
	}
	else {
		die(print_r(sqlsrv_errors(), true));
	}
	
	// retrieve $rsCOMP
	$params = array(array(&$rsCOMP, SQLSRV_PARAM_INOUT));
	$sql = "EXEC dbo.spGetComposition @result=?";
	$stmt = sqlsrv_prepare($con, $sql, $params);
	if($stmt && sqlsrv_execute($stmt)) {
		sqlsrv_next_result($stmt);
		sqlsrv_free_stmt($stmt);
	}
	else {
		die(print_r(sqlsrv_errors(), true));
	}
	
	// retrieve $rsWT
	$params = array(
				array(&$rsWT, SQLSRV_PARAM_INOUT),
				array(&$scenarioYear, SQLSRV_PARAM_IN),
				array(&$transport, SQLSRV_PARAM_IN)
			  );
	$sql = "EXEC dbo.spSourceByComp @result=?, @scenarioYear=?, @transport=0";
	$stmt = sqlsrv_prepare($con, $sql, $params);
	if($stmt && sqlsrv_execute($stmt)) {
		sqlsrv_next_result($stmt);
		sqlsrv_free_stmt($stmt);
	}
	else {
		die(print_r(sqlsrv_errors(), true));
	}
	
	// retrieve $rsTO
	$params = array(
				array(&$rsTO, SQLSRV_PARAM_INOUT),
				array(&$scenarioYear, SQLSRV_PARAM_IN),
				array(&$transport, SQLSRV_PARAM_IN)
			  );
	$sql = "EXEC dbo.spSourceByComp @result=?, @scenarioYear=?, @transport=1";
	$stmt = sqlsrv_prepare($con, $sql, $params);
	if($stmt && sqlsrv_execute($stmt)) {
		sqlsrv_next_result($stmt);
		sqlsrv_free_stmt($stmt);
	}
	else {
		die(print_r(sqlsrv_errors(), true));
	}

	// retrieve $rsDC
	$params = array(
				array(&$rsDC, SQLSRV_PARAM_INOUT),
				array(&$scenarioYear, SQLSRV_PARAM_IN),
				array(&$transport, SQLSRV_PARAM_IN)
			  );
	$sql = "EXEC dbo.spDestByComp @result=?, @scenarioYear=?, @transport=0";
	$stmt = sqlsrv_prepare($con, $sql, $params);
	if($stmt && sqlsrv_execute($stmt)) {
		sqlsrv_next_result($stmt);
		sqlsrv_free_stmt($stmt);
	}
	else {
		die(print_r(sqlsrv_errors(), true));
	}
	
	// source by composition w/o transportation
	$scWT = array(
				'title' => SOURCE_COMP_WT,  // title: Source Emission by Compositions (Without Transportation)...
				'typeid' => 1,
				'type' => 'bar_line',
				'labels' => explode(",", $rsSRC), //label: "Single Family"," Organic"," Non-Organic"...
				'data' => scData($rsCOMP, $rsWT, 'bar') //data: {'label':'Organic','data':...}
			);
	// source by composition w transportation only
	$scTO = array(
				'title' => SOURCE_COMP_TO,
				'typeid' => 1,
				'type' => 'bar_line',
				'labels' => explode(",", $rsSRC),
				'data' => scData($rsCOMP, $rsTO, 'bar')
			);
			
	// destination by composition #0
	$dc0 = array(
				'title' => splitData($rsDEST, 0).' '.DEST_COMP, //title: Vancouver Landfill Emissions by Composition...
				'typeid' => 2,
				'type' => 'pie',
				'data' => dcData($rsCOMP, $rsDC, 0) //data: [{'labels':[Organic, Paper,...], 'data':[...]}]
			);
	$ems = array(   // emission stats
		'results' => 
		[
			$scWT, //source by composition w/o transportation
			$scTO, //source by composition with transportation only
			$dc0 //destination#0 by composition
			//$dc1   //destination#1 by composition
		]
	);
	
	$jsonArray = json_encode($ems);
	// print out the json data
	print $jsonArray;
?>