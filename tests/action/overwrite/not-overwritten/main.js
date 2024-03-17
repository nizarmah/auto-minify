function print_hello() {
	console.log('hello world from overwrite/not-overwritten');
}

window.addEventListener('load', function () {
	print_hello();
});
