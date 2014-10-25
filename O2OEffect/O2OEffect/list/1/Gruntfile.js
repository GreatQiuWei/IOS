module.exports = function(grunt) {

	grunt.initConfig({
		// pkg: grunt.file.readJSON('package.json'),
		concat: {
			options: {
				separator: ';'
			},
			dist: {
				src: [
					'/Users/cyx/Downloads/QQ接收/list/1-民生银行-f/js/animframe_polyfill.js',
					'/Users/cyx/Downloads/QQ接收/list/1-民生银行-f/js/bind_polyfill.js',
					'/Users/cyx/Downloads/QQ接收/list/1-民生银行-f/js/classlist_polyfill.js',
					'/Users/cyx/Downloads/QQ接收/list/1-民生银行-f/js/html_actuator.js',
					'/Users/cyx/Downloads/QQ接收/list/1-民生银行-f/js/input_manager.js',
					'/Users/cyx/Downloads/QQ接收/list/1-民生银行-f/js/local_storage_manager.js',
					'/Users/cyx/Downloads/QQ接收/list/1-民生银行-f/js/grid.js',
					'/Users/cyx/Downloads/QQ接收/list/1-民生银行-f/js/tile.js',
					'/Users/cyx/Downloads/QQ接收/list/1-民生银行-f/js/game_manager.js',
					'/Users/cyx/Downloads/QQ接收/list/1-民生银行-f/js/game_custom.js'
				],
				dest: '/Users/cyx/Downloads/QQ接收/list/1-民生银行-f/js/all.js'
			}
		},
		uglify: {
			// options: {
			//   banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
			// },
			dist: {
				files: {
					'/Users/cyx/Downloads/QQ接收/list/1-民生银行-f/js/all.min.js': ['/Users/cyx/Downloads/QQ接收/list/1-民生银行-f/js/all.js']
				}
			}
		}
	});

	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-concat');


	grunt.registerTask('cc', ['concat']);
	grunt.registerTask('min', ['concat','uglify']);

};