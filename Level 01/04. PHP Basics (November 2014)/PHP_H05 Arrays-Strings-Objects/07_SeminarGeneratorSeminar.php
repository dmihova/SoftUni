<?php
if (isset( $_POST[ 'text' ], $_POST[ 'orderBy' ], $_POST[ 'order' ] ) &&
    !empty( $_POST[ 'text' ] )) {
    $seminars = [];
    $seminarsRawData = preg_split("/\r\n|\n|\r/", $_POST[ 'text' ]);
    foreach ($seminarsRawData as $seminar) {
        $name = substr( $seminar, 0, strpos( $seminar, '-' ) );
        $seminar = substr( $seminar, strlen( $name ) + 1, strlen( $seminar ) );
        $lecturer = substr( $seminar, 0, strpos( $seminar, '-' ) );
        $seminar = substr( $seminar, strlen( $lecturer ) + 1, strlen( $seminar ) );
        $date = substr( $seminar, 0, 16 );
        $description = substr( $seminar, strlen( $date ) + 1, strlen( $seminar ) );
        $seminars[] = (object)[
            'name' => $name, 'lecturer' => $lecturer,
            'date' => $date, 'details' => $description
        ];
    }
    usort( $seminars, function( $a, $b )
    {
        if ($_POST[ 'orderBy' ] == 'name') {
            return $_POST[ 'order' ] == 'ascending' ?
                strcmp( $a->name, $b->name ) : strcmp( $b->name, $a->name );
        } else {
            return $_POST[ 'order' ] == 'ascending' ?
                strtotime( $a->date ) - strtotime( $b->date ) :
                strtotime( $b->date ) - strtotime( $a->date );
        }
    });
}