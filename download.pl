#! /usr/bin/perl
#これからパッケージLWP,URIを使う事を宣言
use LWP::Simple;
use URI::URL;

open(IN, "<TAXID.txt");
@IN = <IN>;
chomp @IN;
$count = @IN + 1;

for($i=0; $i<@IN; $i++){
	$call = $i + 1;
	print $call . " / " . $count . "\n";
	#アクセスするサイトのアドレス
	$address = "http://beta.rest.ensembl.org/taxonomy/id/" . @IN[$i] . "?content-type=application/json";

	# $addressに実際にアクセスするための枠組みを作成
	$url = url($address);

	# GETを用いて通信し、結果を $result の中に入れる
	$result = get($url);

	# パース
	if($result =~ /{\"scientific_name\":\"(.+)?\",\"parent\":/){
		open(OUT, ">>TAXID_TAXNAME.txt");
		print OUT @IN[$i] . "\t" . $1 . "\n";
		close(OUT);
	}	
}

close(IN);


