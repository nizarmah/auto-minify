function print_hello() {
	console.log('hello world from directory/not-affected');
}

window.addEventListener('load', function () {
	print_hello();
});
