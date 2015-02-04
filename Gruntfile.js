module.exports = function(grunt){

    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        clean: ['brainish/'],
        copy: {
            main: {
                expand: true,
                cwd: 'src',
                src: ['**/*.js'],
                dest: 'lib/',
                filter: 'isFile'
            }
        },
        coffee: {
            compile: {
                expand: true,
                cwd: 'src',
                src: ['**/*.coffee'],
                dest: 'brainish/',
                ext: '.js'
            }
        },
        uglify: {
            options: {
                banner: '/*! <%= pkg.name %> - v<%= pkg.version %> (<%= grunt.template.today("yyyy-mm-dd") %>) */\n'
            },
            all: {
                files: [{
                    expand: true,
                    cwd: 'brainish',
                    src: ['**/*.js'],
                    dest: 'brainish',
                    ext: '.js'
                }]
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-uglify');

    // Default task(s).
    grunt.registerTask('default', ['clean', 'copy', 'coffee', 'uglify']);
};